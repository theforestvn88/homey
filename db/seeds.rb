user1 = User.create(email: "test1@example.com", password: "123456")
user2 = User.create(email: "test2@example.com", password: "123456")
project = Project.create(title: "Project 1", description: "This is description of the Project 1 ...", user_id: user1.id)
Assignment.create(project_id: project.id, user_id: user2.id)
