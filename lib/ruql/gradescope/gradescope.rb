module Ruql
  class Gradescope
    # require 'builder'           # optional - if you need XML building; also add in .gemspec
    require 'erb'               # optional - if you need to read/process erb templates
    
    # the main driver will call Ruql::Gradescope#output;
    # can define it as an instance method or attr here
    attr_reader :output

    def initialize(quiz,options={})
      gem_root = Gem.loaded_specs['ruql-gradescope'].full_gem_path rescue '.'

      # Global option `--solutions` means output a quiz WITH solutions, if applicable
      @show_solutions = options.delete('--solutions')

      # Global option `--verbose` means spew debugging info to STDERR
      @verbose = options.delete('--verbose')
      
      # parse your other options here with `arg = options.delete('--option-name')`

      # if you need to have template file(s), put them in GEM_ROOT/templates
      # and set up the filenames here:
      @template = options.delete('--html-template') ||
        File.join(gem_root, 'templates/simple.html.erb')

      # if using Xml::Builder, best to setup its @output target here.
      @output = ''
      @h = Builder::XmlMarkup.new(:target => @output, :indent => 2)

      # A reference to the quiz; we'll need it to iterate over questions
      @quiz = quiz
    end

    # Return a string explaining formatter-specific options
    # and a GetoptLong-style array of how to parse each option (whether
    # the option takes a required argument or no argument).
    def self.allowed_options
      opts = [
        ['--option', GetoptLong::NO_ARGUMENT],
        ['--another-option', GetoptLong::REQUIRED_ARGUMENT]
      ]
      help = <<eos
The Gradescope formatter supports these options:
  --option
      An option that takes no argument
  --another-option=ARGUMENT
      Another option that takes ARGUMENT as an argument.
      Multiline descriptions are fine.
eos
      return [help, opts]
    end

    def render_quiz
      render_with_template do
        render_questions
        @output
      end
      self
    end

    def render_with_template
      # local variables that should be in scope in the template 
      quiz = @quiz
      # the ERB template includes 'yield' where questions should go:
      output = ERB.new(IO.read(File.expand_path @template)).result(binding)
      @output = output
    end
    
    # this is what's called when the Erb template yields, to render all the questions:
    def render_questions
      # Quiz#questions is an iterable of questions
      @quiz.questions.each_with_index do |q,i|
        # dispatch on question's class: MultipleChoice, SelectMultiple, 
        case q
        when MultipleChoice then render_multiple_choice(q,i)
        when SelectMultiple
        when TrueFalse
        when FillIn
        when Dropdown
        else
          raise Ruql::QuizContentError.new "Unknown question type: #{q}"
        end
      end
    end

    # example for formatting a single-answer mult-choice question
    def render_multiple_choice(q,index)
      # q.text => string of question text exactly as it appears in RuQL file
      # q.answers => iterable of Answer instances
      #    answer.correct? => boolean
      #    answer.answer_text => text of answer
      #    answer.has_explanation? => does this answer (right or wrong) have its own hint/explan?
      #    answer.explanation => answer-specific hint/explanation
      # q.raw?  =>  if :raw => true was specified in RuQL, ie question may contain html markup
      # q.tags  => iterable of any tags associated w/question
      # q.group => if non-nil, question's group (intended for "question pool" functionality,
      #            which not all formatters might support)
      #
      # Do something to add quetsion to @output, or write to a file/STDOUT, or whatever
    end

  end
end
