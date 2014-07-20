class TM::TerminalClient
  def initialize
    puts "Welcome to Project Manager Pro. What can I do for you today?\n"
    puts ""
    help
  end

  def help
    puts "Available Commands:"
    puts "  help - Show these commands again"
    puts "  list - List all projects"
    puts "  create NAME - Create a new project with name=NAME"
    puts "  show PID - Show remaining tasks for project with id=PID"
    puts "  history PID - Show completed tasks for project with id=PID"
    puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "  mark PID TID - Mark task with id=TID in project with id=PID as complete"
    grab_input
  end

  def grab_input
    print "> "
    input = gets.chomp
    runner(input)
  end

  def runner(user_string)
    command = user_string.split(" ")
    input = command.shift

    if input == "help"
      help
    elsif input == "list"
      list
    elsif input == "exit"
      puts "Goodbye!"
    elsif input == "create"
      create_proj(command.first)
    elsif input == "show"
      show_incomplete(command.first)
    elsif input == "history"
      show_complete(command.first)
    elsif input == "add"
      add(command.first, command[1], command.last)
    elsif input == "mark"
      mark_complete(command.first, command.last)
    else
      puts "Incorrect input. Type 'help' for more info"
      grab_input
    end

  end

  def list
    projects =  TM::Project.list_projects
    puts "ID    Name"
    projects.each do |project|
      puts " " + project.id.to_s + "    " + project.name.to_s
    end
    grab_input
  end
  
  def create_proj(name)
    TM::Project.new(name)
    grab_input
  end

  def grab_project(proj_id)
    project = TM::Project.grab_project(proj_id)
    project
  end

  def show_incomplete(proj_id)
    project = grab_project(proj_id) 
    tasks = project.grab_incomplete_tasks
    puts "Showing Project \"#{project.name}\""
    puts ""
    puts "Priority    ID  Description"
    tasks.each do |task|
      puts "       #{task.priority_num}    #{task.id}  #{task.desc}"
    end
    grab_input
  end

  def show_complete(proj_id)
    project = grab_project(proj_id)
    tasks = project.grab_complete_tasks
    puts "Showing Project \"#{project.name}\""
    puts ""
    puts "Priority    ID  Description"
    tasks.each do |task|
      puts "       #{task.priority_num}   #{task.id}  #{task.desc}"
    end
    grab_input
  end

  def add(proj_id, priority_num, desc)
    project = grab_project(proj_id)
    project.create_task(desc, priority_num)
    grab_input
  end

  def mark_complete(proj_id, task_id)
    project = grab_project(proj_id)
    project.mark_task_complete(task_id)
    grab_input
  end
end
