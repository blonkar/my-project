class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"
 
  def welcome_email(medicine)
   @medicine = medicine
    @url  = "http://example.com/login"
    @user = User.find(@medicine.user_id)
    mail(:to => @user.email, :subject => "Welcome to My Awesome Site")
  end
  def send_report(medicine)
    @exp_medicine = medicine
    @user = medicine.first.user
    mail(:to => @user.email, :subject => "awesome pdf, check it") do |format|
      format.html # renders send_report.text.erb for body of email
      # format.pdf do
      #   attachments['MyPDF.pdf'] = WickedPdf.new.pdf_from_string(
      #     render_to_string(:pdf => 'MyPDF',:template => 'views/medicines/send_report.pdf.erb')
        
      #end
    end
  end
end

