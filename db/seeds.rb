# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

xero = Company.create!(name: 'Xero', industry: 'finance')
Company.create!(name: 'Australia Post', industry: 'utility')
Company.create!(name: 'Coder Academy', industry: 'education')
envato = Company.create!(name: 'Envato', industry: 'ecommerce')
zendesk = Company.create!(name: 'Zendesk', industry: 'productivity')
atlassian = Company.create!(name: 'Atlassian', industry: 'productivity')
Company.create!(name: 'Gum Tree', industry: 'ecommerce')
Company.create!(name: 'ANZ', industry: 'finance')
cba = Company.create!(name: 'Commonwealth Bank', industry: 'finance')

[xero, envato, zendesk, atlassian, cba].each do |company|
  Job.create!(company: company, title: 'Junior React Developer', front_end: true, back_end: false, description: 'React + JavaScript + Redux')

  Job.create!(company: company, title: 'Junior Rails Developer', front_end: false, back_end: true, description: 'Rails + Ruby + Rspec')

  Job.create!(company: company, title: 'Junior Node.js Developer', front_end: false, back_end: true, description: 'Node.js + JavaScript + Express')

  Job.create!(company: company, title: 'Full Stack Rails Developer', front_end: true, back_end: true, description: 'Rails + Ruby + Rspec + HTML + CSS')
end
