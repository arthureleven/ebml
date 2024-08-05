defmodule EBMLTest do
  use ExUnit.Case

  @files Path.wildcard("test/sources/*.mkv")
  @metadatas [
    [
      Duration: 3600.0,
      SegmentUUID: <<77, 134, 194, 244, 23, 251, 173, 12, 198, 158, 148, 44, 108, 223, 80, 83>>,
      WritingApp: "Lavf53.24.2",
      MuxingApp: "Lavf53.24.2",
      TimestampScale: 1_000_000
    ],
    [
      Duration: 13_346.0,
      SegmentUUID: <<78, 248, 10, 99, 25, 1, 184, 195, 70, 86, 239, 29, 198, 224, 82, 246>>,
      WritingApp: "Lavf57.83.100",
      MuxingApp: "Lavf57.83.100",
      TimestampScale: 1_000_000,
      CRC_32: <<240, 79, 208, 22>>
    ]
  ]

  test "Metadata check" do
    for path <- @files do
      elements =
        File.read!(path)
        |> EBML.decode()

      metadata =
        elements
        |> Keyword.get(:Segment)
        |> Keyword.get(:Info)

      assert metadata in @metadatas
    end
  end
end
