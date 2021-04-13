namespace :db do

  namespace :seed do

    desc "Create Books"
    task :books => :environment do
      books = Book.create([
        {title: 'Eloquent JavaScript, Second Edition', author: 'Marijn Haverbeke',stock: 5},
        {title: 'Learning JavaScript Design Patterns', author: 'Addy Osmani',stock: 8},
        {title: 'Speaking JavaScript', author: 'Axel Rauschmayer',stock: 3},
        {title: 'Understanding ECMAScript 6', author: 'Nicholas C. Zakas',stock: 4},
        {title: 'Designing Evolvable Web APIs with ASP.NET', author: 'Glenn Block, et al.',stock: 10},
        
      ])
    end
  end
end