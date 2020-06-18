require "swagger_helper"

describe "Auth Registration API" do
  path "/api/users" do
    post "Sign up a User" do
      tags "Registration"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              user_name: { type: :string },
              first_name: { type: :string },
              last_name: { type: :string },
              email: { type: :string },
              password: { type: :string },
              dob: { type: :string },
              gender: { type: :string }
            }
          }
        },
        required: ["email", "password", "first_name", "last_name", "user_name"]
      }

      response "200", "User signup" do
        run_test!
      end

      response "400", "invalid request" do
        run_test!
      end
    end
  end
end
