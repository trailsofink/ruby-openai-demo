# Write your solution here!
require 'openai'
require 'dotenv/load'

client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY').to_s)
line_width = 50

puts 'Hello! How can I help you today?'
puts '-' * line_width

user_input = gets.chomp
# Prepare an Array of previous messages
message_list = [
  {
    'role' => 'system',
    'content' => 'You are a helpful assistant who talks like Shakespeare.'
  }
]

# Loops unit user says "bye"
while user_input != 'bye'
  message_list.push({ 'role' => 'user', 'content' => user_input })

  # Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: 'gpt-3.5-turbo',
      messages: message_list
    }
  )

  assistant_response = api_response['choices'][0]['message']['content']
  puts assistant_response
  message_list.push({ 'role' => 'assistant', 'content' => assistant_response })
  puts '-' * line_width

  user_input = gets.chomp
end
