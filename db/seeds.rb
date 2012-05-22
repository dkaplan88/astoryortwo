if Rails.env.development?
  Story.destroy_all
  Submission.destroy_all
  User.destroy_all
end