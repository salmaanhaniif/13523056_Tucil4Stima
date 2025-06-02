# Muat file-file yang berisi modul TSP (solver) dan IOHandler
Code.require_file("solver.exs", __DIR__)
Code.require_file("IOHandler.exs", __DIR__)

defmodule MyApp do
  # Fungsi helper menjadi privat untuk modul MyApp
  defp format_elem(:infinity), do: "∞"
  defp format_elem(val) when is_integer(val) or is_float(val), do: to_string(val)
  defp format_elem(val), do: inspect(val) # Fallback jika ada tipe lain

  def run do
    IO.puts("---------------------------------------------------------------------")
    IO.puts("Selamat Datang di Program Penyelesaian TSP dengan Dynamic Programming")
    IO.puts("---------------------------------------------------------------------")

    input_prompt = "Masukkan path ke file input data matrix (contoh: input.txt): "
    file_path =
      IO.gets(input_prompt)
      |> String.trim()

    if file_path == "" do
      IO.puts("Path file tidak boleh kosong.")
    else
      case IOHandler.read_matrix_from_file(file_path) do
        {:ok, matrix} ->
          IO.puts("\nAdjacency Matrix berhasil dibaca:")
          Enum.each(matrix, fn row ->
            IO.puts(Enum.map(row, &format_elem/1) |> Enum.join("\t"))
          end)

          if length(matrix) < 2 do
            IO.puts("\n[Error Solver] TSP membutuhkan setidaknya 2 kota untuk diselesaikan.")
          else
            {tour, cost} = TSP.solve_tsp(matrix)

            IO.puts("\n--- Hasil TSP ---")
            IO.puts("Tur Optimal ditemukan:")
            IO.puts(Enum.map(tour, &to_string/1) |> Enum.join(" -> "))
            IO.puts("Biaya Minimum Tur: #{format_elem(cost)}")
          end

        {:error, reason} ->
          IO.puts("\n[Error IOHandler] Gagal membaca atau memproses file matrix: #{reason}")
      end
    end

    IO.puts("\n--------------------------")
    IO.puts("Eksekusi program selesai.")
    IO.puts("--------------------------")
  end
end

MyApp.run()
