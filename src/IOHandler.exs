defmodule IOHandler do

  def read_matrix_from_file(filename) do
    with {:ok, content} <- File.read(filename),
         lines <- String.split(content, ~r/\R/, trim: true),
         {[num_cities_line], matrix_lines_str} <- Enum.split(lines, 1),
         {:ok, num_cities} <- parse_num_cities(num_cities_line),
         {:ok, actual_matrix_lines_str} <- validate_matrix_lines_count(matrix_lines_str, num_cities),
         {:ok, matrix} <- parse_matrix_rows(actual_matrix_lines_str, num_cities) do
      {:ok, matrix}
    else
      {:error, :enoent} -> {:error, "File not found: #{filename}"}
      {:error, reason_atom} when is_atom(reason_atom) -> {:error, "Error reading file: #{Atom.to_string(reason_atom)}"}
      {:error, reason_string} when is_binary(reason_string) -> {:error, reason_string}
      _ -> {:error, "Unknown error processing file."}
    end
  end

  defp parse_num_cities(line_str) do
    line_str
    |> String.trim()
    |> String.split(~r/\s|\/\//, parts: 2) # Pisahkan berdasarkan spasi atau //, ambil bagian pertama
    |> List.first()
    |> String.to_integer()
    |> case do
      int_val when is_integer(int_val) and int_val >= 0 -> {:ok, int_val}
      _ -> {:error, "Invalid number of cities: '#{line_str}'. Expected a non-negative integer."}
    end
  rescue
    ArgumentError -> {:error, "Invalid format for number of cities: '#{line_str}'."}
  end

  # Memvalidasi jumlah baris matrix
  defp validate_matrix_lines_count(lines_list, expected_count) do
    actual_count = length(lines_list)
    if actual_count == expected_count do
      {:ok, lines_list}
    else
      {:error, "Incorrect number of matrix rows. Expected #{expected_count}, got #{actual_count}."}
    end
  end

  defp parse_matrix_rows(rows_as_strings, expected_cols_count) do
    Enum.reduce_while(rows_as_strings, {:ok, []}, fn row_str, {:ok, acc_matrix} ->
      element_strings = String.split(String.trim(row_str), " ", trim: true)

      if length(element_strings) != expected_cols_count do
        {:halt, {:error, "Row '#{row_str}' has incorrect number of elements. Expected #{expected_cols_count}, got #{length(element_strings)}."}}
      else
        parsed_row = Enum.map(element_strings, &parse_matrix_element/1)
        {:cont, {:ok, [parsed_row | acc_matrix]}}
      end
    end)
    |> then(fn
      {:ok, matrix_reversed} -> {:ok, Enum.reverse(matrix_reversed)}
      error_tuple -> error_tuple
    end)
  end

  # Mem-parse satu elemen string dari matrix
  defp parse_matrix_element(element_str) do
    trimmed_str = String.trim(element_str)
    case Integer.parse(trimmed_str) do
      {int_val, ""} -> int_val # Berhasil parse integer
      _ -> :infinity         # Jika bukan integer (misal "x"), anggap :infinity
    end
  end
end
