Application.load(:branch_cutter)

for app <- Application.spec(:branch_cutter, :applications) do
  {:ok, _} = Application.ensure_all_started(app)
end

ExUnit.start()
