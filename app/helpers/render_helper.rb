module RenderHelper

    def render_all
        objects = class_name.all
        render_json(objects, class_name: class_string)
    end
    
    def render_where(params)
        objects = class_name.where(params)
        render_json(objects)
    end

    def render_object(object)
        if object
            render_json(object)
        else
            render json: { error: "#{object_string} not found" }, status: :not_acceptable
        end
    end

    def render_one
        object = class_name.find_by(id: params[:id])
        render_object(object)
    end

    def create_and_render
        params = send(class_name.to_s.downcase + '_params')
        object = class_name.create(params)
        render_created(object)
    end

    def save_and_render(object)
        if object.save
            render_created(object)
        else
            failed_to_create(object)
        end
    end

    def render_json(object, class_name: nil, status: :ok)
        render json: serializer(object), status: status
    end

    def render_object_json(object_name, object, status: :ok)
        render json: {
            success: true,
            object_name => object.json
        }, status: :ok
    end

    private

    def class_string
        self.to_s.split('::')[2].split('sController')[0]
    end

    def class_name
        class_string.constantize
    end

    def render_created(object)
        if object.valid?
            render_json(object, status: :created)
        else
            failed_to_create(object)
        end
    end

    def failed_to_create(object)
        object_string = object.class.to_s.downcase
        render json: { error: "failed to create #{object_string}" }, status: :not_acceptable
    end

    def serializer(object)
        serializer_string = class_string + 'Serializer'
        serializer_string.constantize.new(object)
    end

end