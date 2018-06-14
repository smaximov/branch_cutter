Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
  default_release: :default,
  default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"<BI$p:d2K<ugC1zdK2=EW@h!bxdopnv31~*qZfL@ENFZZIYgE!]q]UzMO!*{`0x`"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"78rRMLpTbuV.]/dj`.V3MEq@RF$]U|sHMJCvQxCoikeCy*Y=2A7g468._8V/Hy,$"
end

release :branch_cutter do
  set version: current_version(:branch_cutter)

  set applications: [:runtime_tools]
end
