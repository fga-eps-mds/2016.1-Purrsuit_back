class AchievementsController < ApplicationController

	def all
		@achievement = Achievement.all

		respond_to do |format|
			format.html
			format.json {render json: @achievement}
		end
	end

	def show
		achievement_id = params[:id]
		selected_achievements = Achievement.where(id: achievement_id)
		@achievement = nil
		if selected_achievements.length > 0
			@achievement = selected_achievements.first
		else
			raise "ERROR"
		end
		render json: @achievement
	end

	def new
		@achievement = Achievement.new
	end

	def create
		@achievement = Achievement.new(achievement_params)
		if @achievement.save
			redirect_to :achievements_all
		end
	end

	def edit
		@achievement = Achievement.find(params[:id])
		render 'edit'
	end

	def update
		@achievement = Achievement.find(params[:id])
		if @achievement.update(achievement_params)
			redirect_to :achievements_all
		else
			render 'edit'
		end
	end

	def delete
		id_achievement = params[:id]
		achievements = Achievement.where(id: id_achievement)
		achievement = achievements.first
		achievement.destroy
		redirect_to :achievements_all

	end

	private

	def achievement_params
		params.require(:achievement).permit(:name, :experience_points, :description)
	end
end
