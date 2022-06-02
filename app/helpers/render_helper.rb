module RenderHelper

	def render_json
		@json ||= {}
		success = !@errors && !@error
		json = { success: success, **@json }
		json[:data] = @data if @data
		json[:errors] = @errors if @errors
		json[:error] = @error if @error
		render json: json, status: @status || :ok
	end

end