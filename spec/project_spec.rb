require 'spec_helper.rb'

describe TM::Project do
  let(:project) {TM::Project.new("Test")}

  it "should exist" do
    expect(TM::Project).to be_a(Class)
  end

  describe "#initialize" do
    it "initializes with a name and an id" do
      expect(project.name).to eq("Test")
      expect(project.id).to be_a(Integer)
    end
  end

  describe "#create_task" do
    it "creates a task given a description and a priority number and return the task" do
      task = project.create_task("This is a test", 3)
      expect(task.desc).to eq("This is a test")
      expect(task.priority_num).to eq(3)
    end
  end

  describe "set_task_complete" do
    it "takes a task id and marks the task complete" do
      task = project.create_task("This is a test", 3)
      expect(task.complete).to be_false
      project.mark_task_complete(task.id)
      expect(task.complete).to be_true
    end
  end

  describe "sort_by_date" do
    it "returns an array of tasks sorted by creation date" do
      task1 = project.create_task("This is first", 3)
      task2 = project.create_task("This is second", 3)
      tasks = project.sort_by_date
      expect(tasks.first).to eq(task1)
      expect(tasks.last).to eq(task2)
    end
  end

  describe "sort_by_priority" do
    it "returns an array of task sorted by priority" do
      task1 = project.create_task("This is first", 1)
      task2 = project.create_task("This is second", 3)
      tasks = project.sort_by_priority
      expect(tasks.first).to eq(task1)
      expect(tasks.last).to eq(task2)
    end

    it "returns an array of tasks sorted by priority, same priorities have older first" do
      task1 = project.create_task("This is first", 1)
      task2 = project.create_task("This is second", 1)
      task3 = project.create_task("This is last", 3)
      tasks = project.sort_by_priority
      expect(tasks.first).to eq(task1)
      expect(tasks[1]).to eq(task2)
      expect(tasks.last).to eq(task3)
    end
  end

  describe "#grab_complete_tasks" do
    it "returns an array of complete tasks, sorted by creation date" do
      task1 = project.create_task("This is first", 1)
      task2 = project.create_task("This is second", 2)
      task3 = project.create_task("This isn't complete", 3)
      task1.mark_complete
      task2.mark_complete
      tasks = project.grab_complete_tasks
      expect(tasks.first).to eq(task1)
      expect(tasks.last).to eq(task2)
    end
  end

  describe "#grab_incomplete_tasks" do
    it "returns an array of incomplete tasks, sorted by priority, then creation date" do
      task1 = project.create_task("This is first", 1)
      task2 = project.create_task("This is second", 1)
      task3 = project.create_task("This is last", 2)
      task4 = project.create_task("This isn't there", 2)
      task4.mark_complete
      tasks = project.grab_incomplete_tasks
      expect(tasks.first).to eq(task1)
      expect(tasks[1]).to eq(task2)
      expect(tasks.last).to eq(task3)
    end
  end
end
