defmodule HelloWeb.TopicView do
  use HelloWeb, :view

  def last_topics(topics, count) do
    slice_count = String.to_integer(count) - 1

    topics
    |> Enum.sort_by(fn x -> x.id end)
    |> Enum.reverse()
    |> Enum.slice(0..slice_count)
  end

  def order_by_alphabet(topics) do
    topics
    |> Enum.sort_by(fn x -> x.title end)
    |> IO.inspect(label: "15")
  end

  def order_by_date_new(topics) do
    topics
    |> Enum.sort_by(fn x -> x.id end)
    |> Enum.reverse()
  end

  def order_by_date_old(topics) do
    topics
    |> Enum.sort_by(fn x -> x.id end)
  end
end
