require 'http'

def check(string)
    if string.match(/^http/)
        isvalid = true
        return isvalid
    end
    if !string.match(/^http/)
        isvalid = false
        print "Invalid URL: #{a}"
    end
end

def log(dir)
    
    log = File.new("Valid.log", 'a')
    log.write(dir+"\n")
    log.close
end

def main(ispPass)
    banner = "
    ▄▄                                                              
    ▀███▀▀▀██▄   ██         ▀███▀▀▀███                                           
      ██    ▀██▄              ██    ▀█                                           
      ██     ▀█████ ▀███▄███  ██   █ ▀███  ▀███  █▀▀▀███ █▀▀▀███  ▄▄█▀██▀███▄███ 
      ██      ██ ██   ██▀ ▀▀  ██▀▀██   ██    ██  ▀  ███  ▀  ███  ▄█▀   ██ ██▀ ▀▀ 
      ██     ▄██ ██   ██      ██   █   ██    ██    ███     ███   ██▀▀▀▀▀▀ ██     
      ██    ▄██▀ ██   ██      ██       ██    ██   ███  ▄  ███  ▄ ██▄    ▄ ██     
    ▄████████▀ ▄████▄████▄  ▄████▄     ▀████▀███▄███████ ███████  ▀█████▀████▄   
                                                                                 
                                                                    ~Lojacops       
    {A wise man once said, remember to delete full log files...}
                    
    "
    puts banner
    
    print "Select a target: "
    target = gets.chomp
    if check(target) == true
            print "Select a wordlist: "
            wordlist = gets.chomp
            if File.file?(wordlist) == false
                print "ERROR: Invalid wordlist, please try again."
                return false
            end
            arr_stuff = Array(File.open(wordlist))
            ohyes = arr_stuff.map {|x| x.chomp}
            ohyes.each do |dir|
                uri = "#{target}/#{dir}/"
                req = HTTP.get(uri)
                code = req.code
                if code == 200
                    puts "Valid Dir: \"#{dir}\" - Code: #{code}"
                    log(dir)
                end
                if code != 200
                    puts "Invalid Dir: \"#{dir}\" - Code: #{code}"
                end
            end
    end
end

main()
