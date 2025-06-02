defmodule TSP do
  # Fungsi utama
  def solve_tsp(matrix) do
    n = length(matrix)

    dp =
      for i <- 1..(n - 1), into: %{} do
        key = {Enum.sort([0, i]), i}
        {key, Enum.at(Enum.at(matrix, 0), i)}
      end

    dp =
      for size <- 3..n, reduce: dp do
        acc_dp ->
          subsets = combinations(Enum.to_list(1..(n - 1)), size - 1)

          Enum.reduce(subsets, acc_dp, fn subset, dp_acc ->
            nodes = [0 | subset] |> Enum.sort()

            Enum.reduce(subset, dp_acc, fn k, dp_inner ->
              prev_subset = Enum.sort(List.delete(nodes, k))

              min_cost =
                Enum.map(List.delete(subset, k), fn m ->
                  Map.get(dp_acc, {prev_subset, m}, :infinity) + Enum.at(Enum.at(matrix, m), k)
                end)
                |> Enum.min()

              Map.put(dp_inner, {nodes, k}, min_cost)
            end)
          end)
      end

    # Akhiri dengan kembali ke 0
    full_set = Enum.to_list(0..(n - 1))

    {min_cost, last_node} =
      1..(n - 1)
      |> Enum.map(fn k ->
        cost = Map.get(dp, {full_set, k}, :infinity) + Enum.at(Enum.at(matrix, k), 0)
        {cost, k}
      end)
      |> Enum.min_by(fn {c, _} -> c end)

    # Rekonstruksi path
    path = reconstruct_path(dp, matrix, full_set, last_node)

    {path ++ [0], min_cost}
  end

  # Rekonstruksi path
  defp reconstruct_path(dp, matrix, nodes, last) do
    do_reconstruct(dp, matrix, Enum.sort(nodes), last, [last])
  end

  defp do_reconstruct(_dp, _matrix, [0, _], _current, acc), do: [0 | acc]

  defp do_reconstruct(dp, matrix, nodes, current, acc) do
    candidates = List.delete(List.delete(nodes, 0), current)

    {next_node, _} =
      candidates
      |> Enum.map(fn m ->
        cost =
          Map.get(dp, {Enum.sort(List.delete(nodes, current)), m}, :infinity) +
            Enum.at(Enum.at(matrix, m), current)
        {m, cost}
      end)
      |> Enum.min_by(fn {_, c} -> c end)

    do_reconstruct(dp, matrix, List.delete(nodes, current), next_node, [next_node | acc])
  end

  # Kombinasi dari elemen
  defp combinations(_, 0), do: [[]]
  defp combinations([], _), do: []
  defp combinations([h | t], k),
    do: (for tail <- combinations(t, k - 1), do: [h | tail]) ++ combinations(t, k)
end
