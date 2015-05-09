require 'opennebula'
require_relative '../lib/config'
require_relative '../lib/provisioner'
require_relative '../lib/utils'
require_relative '../lib/stages'
require 'yaml'
require 'minitest/autorun'

class TestStages < Minitest::Test

  def test_script_template_stage
  end

  def test_tar_stage
  end

  def test_basic_script_stage
  end

  def test_directory_stage
    instance = Stages::Directory.new(File.expand_path(File.dirname __FILE__) + '/harness/directory', ['arg1', 'arg2'], 1)
    commands = instance.commands('127.0.0.1')
    assert(commands.length == 2, "There are two commands")
    first_command = commands[0]
    assert(first_command["scp"], "First command copies stuff with scp")
    assert(first_command["-r"], "It has the recursive flag")
    assert(first_command["root"], "We copy using the root user")
    assert(first_command['./harness/directory'], "We copy the right directory")
    assert(first_command['stage-1'], "We copy to stage-1 directory")
    assert(first_command['127.0.0.1'], "We copy stuff to the right place")
    second_command = commands[1]
    assert(second_command["bash setup.sh"], "We run setup.sh with bash")
    assert(second_command["\"arg1\""], "First argument is there")
    assert(second_command["\"arg2\""], "Second argument is there")
    assert(second_command["touch 1-done"], "We indicate when we are done")
    assert(second_command["pushd stage-1"], "We push the directory and don't just cd into it")
    assert(second_command["popd"], "We also popd in case of success")
    assert(second_command['127.0.0.1'], "We run on the right server")
    assert(second_command['root'], "We run as root")
  end

  def test_inline_stage
    instance = Stages::Inline.new('echo hi', 1)
    commands = instance.commands('127.0.0.1')
    assert(commands.length == 1, "Inline stages have only 1 command")
    command = commands[0]
    assert(command['root@127.0.0.1'], "We log in as root")
    assert(command['1-done'], "We touch a file to indicate the stage is done")
    assert(command['echo hi'], "The command actually includes the command we want to run")
  end

end
