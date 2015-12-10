class Users::RegistrationsController < Devise::RegistrationsController
    def create
        #import the Devise create method so we can just add to it and not totally overwrite
        super do |resource|
            if params[:plan]
                # add the plan_id to the users row in database
                resource.plan_id = params[:plan]
                #check which plan they signed up with
                if resource.plan_id == 2
                    
                    resource.save_with_payment
                else
                    resource.save
                end
            end
        end
    end
end