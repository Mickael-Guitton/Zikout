class MembersController < ApplicationController
  def create
    @member = Member.new(member_params)
    @member.user = current_user
    if @member.save
      redirect_to profile_path
    else
      render :new
    end
  end

  private

  def member_params
    params.require(:member).permit(:nickname, :instrument)
  end
end
