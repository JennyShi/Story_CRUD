=begin
  
Author: Junyi Shi
Version: 1.0
Organization: EMC Corporation
Date Created: 12/16/2013.

Description: This is a simple script for create/update/delete user stories from csv file.
  
=end

require 'rally_api_emc_sso' 

class Story_CRUD
  def initialize (workspace,project)
    headers = RallyAPI::CustomHttpHeader.new()
    headers.name = 'My Utility'
    headers.vendor = 'MyCompany'
    headers.version = '1.0'

    #==================== Making a connection to Rally ====================
    config = {:base_url => "https://rally1.rallydev.com/slm"}
    config = {:workspace => workspace}
    config[:project] = project
    config[:headers] = headers #from RallyAPI::CustomHttpHeader.new()

    @rally = RallyAPI::RallyRestJson.new(config)
    #puts "Workspace #{@workspace}"
    #puts "Project #{@project}"
  end

#check http://developer.help.rallydev.com/ruby-toolkit-rally-rest-api-json 
#use the example on this page from "Querying Rally" 

  def find_project(project_name)
    query = RallyAPI::RallyQuery.new()
    query.type = :project
    query.fetch = "Name"
    query.query_string = "(Name = \"#{project_name}\")"
    result = @rally.find(query)

    if(result.length != 0)
      puts "find the project #{project_name}"
    else 
      puts "project #{project_name} not found"
      #exit
    end
    result
  end

  def find_userstory(row)
    query = RallyAPI::RallyQuery.new()
    query.type = "HierarchicalRequirement"
    query.fetch = "Name,FormattedID"
    query.query_string = "(FormattedID = \"#{row["Formatted ID"]}\")"
    results = @rally.find(query)
  
 # result.first.read
 # puts result.first.read.Children.size
  
    if (results.length != 0)
      results.each do |res|
        res.read
        puts "Find #{res.FormattedID}"
      end
    else
      puts "No such user story #{row["Formatted ID"]}"
    end
    results
  end

  def create_userstory(row)
    puts "Creating..."
    results = find_project(row["Project"])
    @re = results.first
  
    field = {}
    field["Name"] = row["Name"]
    field["Project"] = @re["_ref"]
    field["Description"] = row["Description"]
    if (field["Owner"] != nil)
      field["Owner"] = row["Owner"]
    end
    field["State"] = row["State"]
    create_userstory= @rally.create("story",field)
    puts "#{row["Name"]} created"
    puts "\n"
    
  end
  
  def update_userstory(row)
  puts "Managing row #{@iCount}"
  puts "Updating..."
  #result = find_project(row["Project"])
  if(find_project(row["Project"])!= nil)
    result = find_userstory(row)
    if(result.length != 0)
      @userstory = result.first
      puts @userstory["_ref"]
      field = {}
      
      if (row["New Name"] != nil)
        field["Name"] = row["New Name"]
        @rally.update("story","#{@userstory["_ref"]}",field)
        puts "#{row["Name"]} updated"

      end
  
      if (row["New Project"] != nil)
        res = find_project(row["New Project"])
        @res = res.first
        field["Project"] = @res["_ref"]
        @rally.update("story","#{@userstory["_ref"]}",field)
        puts "#{row["Name"]} updated"

      end
      
      if (row["New Description"] != nil)
        field["Description"] = row["New Description"]
        @rally.update("story","#{@userstory["_ref"]}",field)
        puts "#{row["Name"]} updated"

      end
      
      if (row["New Owner"] != nil)
        field["Owner"] = row["New Owner"]
        @rally.update("story","#{@userstory["_ref"]}",field)
        puts "#{row["Name"]} updated"
 
      end
      
      if (row["New State"] != nil)
        field["State"] = row["New State"]
        @rally.update("story","#{@userstory["_ref"]}",field)
        puts "#{row["Name"]} updated"
 
      end
    end
  end
end

def delete_userstory(row)
  puts "Managing row #{@iCount}"

  if(find_project(row["Project"]) != nil)
    result = find_userstory(row)
    if(result.length != 0)
      @userstory = result.first
      puts @userstory["_ref"]
      puts "Deleting..."
      @rally.delete(@userstory["_ref"])
      puts "#{row["Name"]} deleted"
    end
  else
    puts "Delete #{row["Name"]} failed!"
  end
end

def read_userstory(row)
    query = RallyAPI::RallyQuery.new()
    query.type = "HierarchicalRequirement"
    query.fetch = "Name,FormattedID"
    query.query_string = "(FormattedID = \"#{row["Formatted ID"]}\")"
    results = @rally.find(query)
  
 # result.first.read
 # puts result.first.read.Children.size
  
    if (results.length != 0)
      results.each do |res|
        res.read
        puts "Find #{res.FormattedID}"
        puts "Name: #{res.Name}"
        puts "Description: #{res.Description}"
        puts "Project: #{res.Project}"
        puts "Owner: #{res.Owner}"
        puts "State: #{res.State}"
      end
    else
      puts "No such user story #{row["Formatted ID"]}"
    end
    results
  end
end