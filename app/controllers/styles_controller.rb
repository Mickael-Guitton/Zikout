class StylesController < ApplicationController
  def create
    @style = Style.new(style_params)
    @style.user = current_user
    if @style.save
      redirect_to profile_path
    else
      render :new
    end
  end

  private

  def style_params
    params.require(:style).permit(:content)
  end
end
