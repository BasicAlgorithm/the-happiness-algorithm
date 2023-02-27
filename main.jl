module TheHappinessCode
export Me

questions::Vector{String} = [
    "What is your name (optional)",
    "What gives me meaning?",
    "What gives me pleasure?",
    "What are my strengths?",
]
title_words::Vector{String} = ["meaning", "pleasure", "strengths"]

Base.@kwdef mutable struct Me
    name::String
    sleep_hours::Int64 = 0
    percentaje_happiness::Int64 = 0

    meaning::Vector{String} = []
    pleasure::Vector{String} = []
    strengths::Vector{String} = []
end # Me

function instructions()
    println("You have to take some minutes for answer these questions. 
    The more seriously you answer the questions, 
    more accurate will be the algorithm.")
end # instructions

function add_more_responses()::String
    answer::String = ""
    while true
        println("Do you want to add one more? yes | not")
        answer = readline()
        answer = lowercase(answer)
        if answer == "not" || answer == "yes"
            break
        else
            println("*** Your answer is not valid, write yes or not please. ***")
        end
    end
    answer
end # add_more_responses

function horizontal_line(size::Int)
    println("   ", "-"^(size * 3 + 4))
end

function gui(me::Me)
    max_lenght_responses::Int8 = max(length(me.meaning), length(me.pleasure), length(me.strengths))
    max_size_words = max(
        length(me.meaning) > 0 ? maximum(length, me.meaning) : 0,
        length(me.pleasure) > 0 ? maximum(length, me.pleasure) : 0,
        length(me.strengths) > 0 ? maximum(length, me.strengths) : 0,
        maximum(length, TheHappinessCode.title_words))
    title = [i * (" "^(max_size_words - length(i) + 1)) for i in title_words]
    title = join(title)
    horizontal_line(max_size_words)
    println("    ", "THE CODE OF HAPPINESS")
    horizontal_line(max_size_words)
    greeting = "Hi $(me.name)"
    println("    ", greeting)
    println("    ", "These are your responses...")
    horizontal_line(max_size_words)
    println("    ", title)
    horizontal_line(max_size_words)

    i::Int8 = 1
    while i <= max_lenght_responses
        togui::String = ""
        if i <= length(me.meaning)
            togui *= me.meaning[i] * (" "^(max_size_words - length(me.meaning[i])))
        else
            togui *= " "^max_size_words
        end
        togui *= " "
        if i <= length(me.pleasure)
            togui *= me.pleasure[i] * (" "^(max_size_words - length(me.pleasure[i])))
        else
            togui *= " "^max_size_words
        end
        togui *= " "
        if i <= length(me.strengths)
            togui *= me.strengths[i] * (" "^(max_size_words - length(me.strengths[i])))
        else
            togui *= " "^max_size_words
        end
        println("    ", togui)
        i += 1
    end # while
    horizontal_line(max_size_words)
    println("")
end # gui

function final_questions!(me::Me)
    # TODO
    # add some final questions
    println("How many hours you sleep each day on average?")
    answer = parse(Int64, readline())
    me.sleep_hours = answer
end

function calculate_happiness(me::Me)
    
    println("You are $percentaje_happiness")
end

end # TheHappinessCode

############################################################################################

# The code start here
using .TheHappinessCode

me = Me(name="Fido")
question_number::Int8 = 1

println(TheHappinessCode.questions[1])
answern = readline()
me.name = answern
run(`clear`)
TheHappinessCode.gui(me)

while true
    println(">>> Write one thing that has meaning for you")
    answerm = readline()
    push!(me.meaning, answerm)
    answerm = TheHappinessCode.add_more_responses()
    if answerm == "not"
        run(`clear`)
        TheHappinessCode.gui(me)
        break
    end
    run(`clear`)
    TheHappinessCode.gui(me)
end

while true
    println(">>> Write one thing that gives you pleasure")
    answerp = readline()
    push!(me.pleasure, answerp)
    answerp = TheHappinessCode.add_more_responses()
    if answerp == "not"
        run(`clear`)
        TheHappinessCode.gui(me)
        break
    end
    run(`clear`)
    TheHappinessCode.gui(me)
end

while true
    println(">>> Write one thing that you consider your strengths")
    answers = readline()
    push!(me.strengths, answers)
    answers = TheHappinessCode.add_more_responses()
    if answers == "not"
        run(`clear`)
        TheHappinessCode.gui(me)
        break
    end
    run(`clear`)
    TheHappinessCode.gui(me)
end

TheHappinessCode.final_questions!(me)
TheHappinessCode.calculate_happiness(me)