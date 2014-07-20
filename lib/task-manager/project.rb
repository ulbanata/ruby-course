class TM::Project
  attr_reader :name, :id  
  @@counter = 0
  @@projects = {}

  def initialize(name)
    @name = name
    @id = @@counter += 1
    @tasks = {}
    @@projects[@id] =  self
  end

  def create_task(desc, priority_num)
    task = TM::Task.new(@id, desc, priority_num)
    @tasks[task.id] = task
    task
  end

  def mark_task_complete(task_id)
    @tasks[task_id].mark_complete
  end

  def sort_by_date
    sorted = @tasks.sort_by { |id, task| task.creation }
    sorted.map { |x| x.last }
  end

  def sort_by_priority
    sort_by_date.sort_by { |task| task.priority_num }
  end

  def grab_complete_tasks
    sort_by_date.select { |task| task.complete }
  end

  def grab_incomplete_tasks
    sort_by_priority.select { |task| !task.complete }
  end

  def self.list_projects
    @@projects.map { |id, project| project }
  end

  def self.grab_project(pid)
    project = @@projects[pid.to_i]
    project
  end
end
