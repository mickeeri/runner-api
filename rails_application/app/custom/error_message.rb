class ErrorMessage
  def initialize(status, dev_mess, usr_mess)
    # This is going to be json...camelcase
    @status = status
    @developer_message = dev_mess
    @user_message = usr_mess
  end
end
