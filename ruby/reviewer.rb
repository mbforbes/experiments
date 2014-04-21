QA = Struct.new( :question, :answer )

def reviewApp
  puts "\n +----------------------------------------------------------+"
  puts " | Welcome to the greatest review application on the table. |"
  puts " +----------------------------------------------------------+\n\n"

  if not ARGV[0]
    puts "You gotta provide a .txt file to review!"
    exit
  end

  topics = getFileData( ARGV[0] )
  topicSelection(topics)

  puts "\nLet us retire for a well-deserved rest.\n\n"
end

def getFileData(reviewFile)
  topicLabel = "Topic: "

  topics = Hash.new
  lines = File.open(reviewFile, 'rb').read.split("\n").delete_if { |line|
    line.nil? or line.strip.empty? or line.strip.start_with?("-")
  }
  
  curQA = QA.new
  curOnQ = true
  currentTopic = "should never see this"
  lines.each { |line| 
    if line.start_with?(topicLabel)
      topicName = line[topicLabel.length..-1]
      topics[topicName] = Array.new
      currentTopic = topicName
    else 
      if curOnQ
        curQA = QA.new
        curQA.question = line
        curOnQ = false
      else
        curQA.answer = line
        topics[currentTopic] << curQA
        curOnQ = true;
      end
    end
  }

  return topics
end

def topicSelection(topics)
  finished = false
  while not finished
    puts "Type in the name of a topic to start reviewing it, or type 'q' to quit\n\n"
    topics.each { |topicName, qaList|
      puts topicName
    }
    print "\n> "
    answer = STDIN.gets.strip
    if answer == 'q'
      finished = true
    elsif topics[answer].nil?
      puts "Bad answer, try again."
    else
      questionLoop(topics[answer])
    end
  end
end

def questionLoop(qaList)
  puts "Here are all of the questions/answers. Continue with 'ENTER', press 'q' to quit any time.\n\n"
  qaList.each { |qa|
    puts qa.question
    if STDIN.gets.strip == 'q'
      return
    end
    puts "\t" + qa.answer
    if STDIN.gets.strip == 'q'
      return
    end
  }
  puts "Great jorb! That completes the set."
end

def printAllData(topics)
  topics.each { |topicName, qaList|
    puts topicName
    qaList.each { |qa|
      puts qa.question
      puts qa.answer
    }
  }
end

# execution starts here
reviewApp
