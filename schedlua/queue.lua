--[[
	Queue
--]]
local Queue = {}
setmetatable(Queue, {
	__call = function(self, ...)
		return self:create(...);
	end,
});

local Queue_mt = {
	__index = Queue;
}

Queue.init = function(self, first, last, name)
	first = first or 1;
	last = last or 0;

	local obj = {
		first=first, 
		last=last, 
		name=name};

	setmetatable(obj, Queue_mt);

	return obj
end

Queue.create = function(self, first, last, name)
	first = first or 1
	last = last or 0

	return self:init(first, last, name);
end

--[[
function Queue.new(name)
	return Queue:init(1, 0, name);
end
--]]

function Queue:enqueue(value)
	--self.MyList:PushRight(value)
	local last = self.last + 1
	self.last = last
	self[last] = value

	return value
end

function Queue:pushFront(value)
	-- PushLeft
	local first = self.first - 1;
	self.first = first;
	self[first] = value;
end

function Queue:dequeue(value)
	-- return self.MyList:PopLeft()
	local first = self.first

	if first > self.last then
		return nil, "list is empty"
	end
	
	local value = self[first]
	self[first] = nil        -- to allow garbage collection
	self.first = first + 1

	return value	
end

function Queue:highestPriority(value)
	-- return self.MyList:PopLeft()
	local first = self.first

	if first > self.last then
		return nil, "list is empty"
	end
	
	-- Loop through all the tasks to find the highest priority.
	local highestPriority = 100
	print("highestPriority: "..highestPriority)

	local highestPriTaskId
	for taskId = self.first, self.last do
		print("taskId: "..taskId)

		local task = self[taskId]  

		if (task ~= nil) then
			print("we're not nil")
      
			local taskPri = task.params[1]
      if taskPri ~= nil then
        print("taskPri: "..taskPri)
        
        if (taskPri < highestPriority) then
          --if it's a higher priority, then save the priority to compare with the next tasks
          highestPriority = taskPri
          print("highestPriority: "..highestPriority)
          --Save the taskID so we can return the highest priority task later
          highestPriTaskId = taskId
          print("highestPriTaskId: "..highestPriTaskId)
        end
      end
		end
	end
  --after the loop finishes, use the highest priority task id and return the highest priority task
	local value = self[highestPriTaskId]

	-- Shift the tasks to fill in the blank where the highest priority used to be.
	--[[for priority = highestPriority+1, self.last do
		self[priority-1] = self[priority]
	end

	-- Clear the last task since every shifted over one.
	self[self.last] = nil        -- to allow garbage collection]]

	return value	
end

function Queue:length()
	return self.last - self.first+1
end

-- Returns an iterator over all the current 
-- values in the queue
function Queue:Entries(func, param)
	local starting = self.first-1;
	local len = self:length();

	local closure = function()
		starting = starting + 1;
		return self[starting];
	end

	return closure;
end


return Queue;
