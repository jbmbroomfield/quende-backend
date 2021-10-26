module RenderHelper

    def render_all
        objects = class_name.all
        render_json(objects, class_name: class_string)
    end

    def render_one(class_name)
        object = class_name.find_by(id: params[:id])
        if object
            render_json(object)
        else
            render json: { error: "#{object_string} not found" }, status: :not_acceptable
        end
    end

    def create_and_render(class_name)
        params = send(class_name.to_s.downcase + '_params')
        object = class_name.create(params)
        render_created(object)
    end

    private

    def class_string
        self.to_s.split('::')[2].split('sController')[0]
    end

    def class_name
        class_string.constantize
    end

    def render_json(object, class_name: nil, status: :ok)
        render json: serializer(object, class_name), status: status
    end

    def render_created(object)
        if object.valid?
            render_json(object, status: :created)
        else
            object_string = object.class.to_s.downcase
            render json: { error: "failed to create #{object_string}" }, status: :not_acceptable
        end
    end

    def serializer(object, class_string=null)
        class_string ||= object.class.to_s
        serializer_string = class_string + 'Serializer'
        serializer_string.constantize.new(object)
    end

end