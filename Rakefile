require 'mkmf'

if find_executable 'luaenv' then
  # luaenv specific setting
  ENV['LUAENV_ROOT']="#{ENV['HOME']}/.luaenv"
  LUAENV_EXEC="exec #{ENV['LUAENV_ROOT']}/libexec/luaenv exec"
else
  LUAENV_EXEC=""
end

TARGET = "ds"
LUA = ENV["LUA"] || "luajit"
LUAFLAGS = "-lalgo -lds"
LUAROCKS = ENV["LUAROCKS"] || "luarocks"
ROCKSPEC = "ds-0.1.0-1.rockspec"
LDOC = "ldoc"
DOC_DIR = "doc"
TEST_DIR = "test"
RM = "rm"
RMFLAGS = "-rf"

task 'test' => [:install] do
  Dir.glob(File.join("**", "test", "*.lua")).each do |t|
    sh "#{LUAENV_EXEC} #{LUA} #{LUAFLAGS} #{t}"
  end
end

task 'clean' do
  sh "#{RM} #{RMFLAGS} #{DOC_DIR}"
end

task 'install' => [:doc] do
  if find_executable 'luaenv' then
    sh "#{LUAENV_EXEC} #{LUAROCKS} make #{ROCKSPEC}"
  else
    sh "#{LUAROCKS} make #{ROCKSPEC} --local"
  end
end

task 'uninstall' do
  begin
    if find_executable 'luaenv' then
      sh "#{LUAENV_EXEC} #{LUAROCKS} remove #{TARGET} --force"
    else
      sh "#{LUAROCKS} remove #{TARGET} --local --force"
    end
  rescue
    # Do nothing even the task failed
  end
end

task 'doc' do
  sh "#{LDOC}", "."
end
