class Api::V1::FlagsController < ApplicationController

  before_action :require_login

  def create
    flag = Flag.find_or_create_by(flag_params) do |flag|
      if ['like', 'dislike'].include?(flag_params[:category])
        opposite_flag = Flag.find_by(opposite_flag_params)
        opposite_flag.destroy if opposite_flag
      end
    end
    render_object(flag)
  end

  def destroy
    flag = Flag.find_by(flag_params)
    if flag
      flag.destroy
      render json: { message: "deleted flag" }, status: :ok
    else
      render json: { error: "flag not found" }, status: :not_acceptable
    end
  end

  private

  def category
    params.require(:flag).permit(:category)[:category]
  end

  def opposite_category
    {
      'like' => 'dislike',
      'dislike' => 'like',
      'important' => 'unimportant',
      'unimportant' => 'important',
      'agree' => 'disagree',
      'disagree' => 'agree',
    }[category]
  end

  def post_id
    params[:post_id].to_i
  end

  def flag_params
    {post_id: post_id, user: current_user, category: category}
  end

  def opposite_flag_params
    {post_id: post_id, user: current_user, category: opposite_category}
  end

end
