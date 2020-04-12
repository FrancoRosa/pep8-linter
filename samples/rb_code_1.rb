# rubocop:disable all

 require "my_module" 
def find_py_files(directories) 
    if directories.size.zero?
        Dir[__dir__ + '/*.py']
    else
        Dir[directories[0] + '/*.py']
    end
  end

# rubocop:enable all