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
      sh "#{LUA} #{LUAFLAGS} #{t}"
  end
end

task 'clean' do
  sh "#{RM} #{RMFLAGS} #{DOC_DIR}"
end

task 'install' => [:doc] do
  sh "#{LUAROCKS}", "make", "#{ROCKSPEC}", "--local"
end

task 'uninstall' do
  begin
    sh "#{LUAROCKS}", "remove", "#{TARGET}", "--local", "--force"
  rescue
    # Do nothing even the task failed
  end
end

task 'doc' do
  sh "#{LDOC}", "."
end
