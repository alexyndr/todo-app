 # README

You can find deployed app at address:

https://salty-headland-46880.herokuapp.com


 I have column (completed_at) instead (status). 
  When I made project I made decision create column DATETIME type
  for status instead BOOLEAN. So i changed it in SQL task.

SQL task
Given tables:
  01. tasks (id, name, status, project_id)
    projects (id, name)

Technical requirements
  - get all statuses, not repeating, alphabetically ordered:
    -----
    SELECT DISTINCT completed_at FROM todo_items WHERE completed_at IS NOT NULL ORDER BY completed_at;

  - get the count of all tasks in each project, order by tasks count descending:
    -----
    SELECT todo_list_id, count(todo_list_id) FROM todo_items GROUP by todo_list_id ORDER BY 2 DESC;

  - get the count of all tasks in each project, order by projects names:
    -----
    SELECT todo_items.todo_list_id, count(todo_list_id), todo_lists.title FROM todo_items 
    JOIN todo_lists ON todo_items.todo_list_id = todo_lists.id GROUP by todo_list_id ORDER BY title;

  - get the tasks for all projects having the name beginning with "N" letter:
    -----
    SELECT "todo_items".* FROM "todo_items"  WHERE content LIKE 'N%';

  - get the list of all projects containing the 'a' letter in the middle of 
    the name, and show the tasks count near each project. Mention 
    that there can exist projects without tasks and tasks with 
    project_id = NULL
    -----
    SELECT "todo_lists".*, count(todo_list_id) FROM "todo_lists" 
    JOIN todo_items ON todo_lists.id = todo_items.todo_list_id GROUP by todo_list_id HAVING title LIKE '%a%';           
    (SELECT IFNULL(count(todo_list_id), 0) FROM todo_lists) - **HOUSTON WE HAVE A PROBLEM!**

  - get the list of tasks with duplicate names. Order alphabetically
    -----
    SELECT "todo_items".* FROM "todo_items"  GROUP BY content HAVING count(*) > 1 ORDER BY content;

  - get list of tasks having several exact matches of both name and 
    status, from the project 'Garage'. Order by matches count
    -----
    SELECT * FROM "todo_items" t WHERE 1 < (SELECT count(*) FROM "todo_items" i 
    WHERE  i.deadline =  t.deadline AND i.content = t.content);

  - get the list of project names having more than 10 tasks in status 'completed'. Order by project_id
    -----
    SELECT todo_items.todo_list_id, count(todo_list_id), todo_lists.title FROM todo_items 
    JOIN todo_lists ON todo_items.todo_list_id = todo_lists.id GROUP by todo_list_id 
    HAVING count(*) > 10 AND completed_at IS NOT NULL ORDER BY todo_lists.id;