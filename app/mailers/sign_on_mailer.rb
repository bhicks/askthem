class SignOnMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  default from: "develop@opengovernment.org"
  def signed_on(user, question)
    @user = user
    @question = question
    mail(:to => user.email,
        :subject => "You Successfully Signed " + @question.title)
  end
end
