require 'http'

def fuzzer
    begin
        puts "\rlink:"
        fuzz_option = gets.chomp
        print fuzz_option
        puts "\rselect a wordlist:"
        wordlist_option = gets.chomp
        print wordlist_option
        wordlist = Array(File.open(wordlist_option))
        ohyes = wordlist.map {|x| x.chomp }
        ohyes.each do |dir|
            uri = "#{fuzz_option}/#{dir}/"
            request = HTTP.get(uri)
            print request.code
            if request.code == 200
                puts "\rdirectory open! '#{dir}'"
            elsif request.code == 404
                puts "\rscanning..."       #directory closed
            end
        end        
    rescue Errno::ENOENT
        puts "\rERROR: Select a valid wordlist"
        return false
    rescue HTTP::ConnectionError
        puts "\rERROR: Select a valid link"
        return false
    end
end
print fuzzer
