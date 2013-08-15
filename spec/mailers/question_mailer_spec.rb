require "spec_helper"

describe QuestionMailer do

  it "sends question posted e-mail" do
    user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question)
    QuestionMailer.question_posted(user, question).deliver
    last_email = ActionMailer::Base.deliveries.last

    last_email.to.should == [user.email]
    last_email.from.should eq(["develop@opengovernment.org"])
    last_email.subject.should eq("Your Question on AskThem Has Been Posted")
    last_email.body.encoded.should match( question_url(question.state, question.id) )
  end
end

describe SignOnMailer do

  it "sends signed on to question e-mail" do
    user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question)
    SignOnMailer.signed_on(user, question).deliver
    last_email = ActionMailer::Base.deliveries.last
    last_email.to.should == [user.email]
    last_email.from.should == ["develop@opengovernment.org"]
    last_email.subject.should == "You Successfully Signed " + question.title
    last_email.body.encoded.should match(question_url(question.state, question.id))

  end
end
