defmodule Knn do
  def get_nearest do
    [test_item | training_data] = Enum.shuffle(parse)
    IO.inspect test_item

    closest_point = training_data
                    |> to_distances(Enum.take(test_item, 4))
                    |> Enum.sort
                    |> hd 

    IO.inspect closest_point
  end

  defp parse do
    NimbleCSV.define(MyParser, separator: ",", escape: "\"")

    "iris.data"
    |> File.read!
    |> MyParser.parse_string
    |> Enum.map(fn [a, b, c, d, label] ->
         [String.to_float(a), String.to_float(b),
          String.to_float(c), String.to_float(d),
          label]
    end)
  end

  defp to_distances(dataset, test_point) do
    dataset
    |> Enum.map(fn [a, b, c, d, label] ->
        %{distance: distance([a, b, c, d], test_point), label: label}
    end)
  end

  defp distance([a1, b1, c1, d1], [a2, b2, c2, d2]) do
    :math.sqrt(:math.pow(a1 - a2, 2) + :math.pow(b1 - b2, 2) + :math.pow(c1 - c2, 2) + :math.pow(d1 - d2, 2))
  end
end
