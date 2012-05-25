if Rails.env.development?
  Story.destroy_all
  Submission.destroy_all
  User.destroy_all
  Invite.destroy_all
  Line.destroy_all
  
  User.create login: "Andrew", name: "Andrew", password: "tree", password_confirmation: "tree"
  Story.create title: "Jack & Jill"
  Line.create content: "Jack and Jill went up a hill to fetch a pail of water", user_id: 1, story_id: 1
  puts "All set, user login is Andrew, pw is tree"
end