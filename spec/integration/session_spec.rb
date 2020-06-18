require "swagger_helper"

describe "Auth Session API" do
  path "/api/users/sign_in" do
    post "Creates a Session" do
      tags "Session"
      consumes "application/json"
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          session: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              role: { type: :string }
            }
          }
        },
        required: ["email", "password", "role"]
      }

      response "200", "Session created" do
        run_test!
      end

      response "400", "invalid request" do
        run_test!
      end
    end
  end

  path "/api/users/confirm_email" do
    post "Checks if email exists" do
      tags "Session"
      consumes "application/json", "application/xml"
      # parameter name: :id, in: :path, type: :string
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          session: {
            type: :object,
            properties: {
              email: { type: :string }
              # password: { type: :string },
              # role: { type: :string }
            }
          }
        },
        required: ["email"]
      }

      response "200", "Email found" do
        run_test!
      end

      response "404", "Email not found" do
        run_test!
      end
    end
  end
end
