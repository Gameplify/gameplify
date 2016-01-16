package gameplify
class UserController {
	def userService
	def gameService
	private static final okcontents = ['image/png', 'image/jpeg', 'image/gif']
		def index={
			redirect(action:"login")
		}
		
		def userProfile(){
			def user = userService.findUser(params.userId)
			if (user.role == "Admin"){
				redirect(action:"adminProfile" ,parameters:[admin:user])
			}
			[user:user]
		}
		
		def adminActivities(){
			log.println(params.adminId)
			def activities = userService.getAdminActivity(params.adminId)
			log.println("wow"+activities)
			render(template: 'adminActivities', model:[activities:activities])
		}
		
		def getUserRating(){
			def rating = userService.getUserRating(params.gameId, params.userId)
			[rating:rating]
		}
		
		def avatar_image() {
			def avatarUser = User.get(params.id)
			if (!avatarUser || !avatarUser.avatar || !avatarUser.avatarType) {
			  response.sendError(404)
			  return
			}
			response.contentType = avatarUser.avatarType
			response.contentLength = avatarUser.avatar.size()
			OutputStream out = response.outputStream
			out.write(avatarUser.avatar)
			out.close()
		  }
		
		def upload_avatar() {
			
			print "wew"

			def f = request.getFile('avatar')
		  
			if(f){
				print "yow"
			} else {
				print "you fail fucker"
			}
			
			
			if (!okcontents.contains(f.getContentType())) {
			  flash.message = "Avatar must be one of: ${okcontents}"
			  redirect(uri: request.getHeader('referer') )
			  return
			}
		  
			
			if(!userService.uploadAvatar(session.user.id, f)){
			render(view:'select_avatar', model:[user:user])
			print "too big"
			return
		}
			
			redirect(uri: request.getHeader('referer') )
		  }
		
		def adminProfile(){
			if((!(session.user))||session?.user?.role != "Admin"){
				flash.message = "You do not have permission to access this page"
				redirect(controller:"game", action: "index")
			} else {
			def admin = params.admin
			def admins = userService.listAdmins()
			[admin:admin, admins:admins]
			}
		}
		
		def showUserAuthentication(){
			render(template: '../userAuthentication')
		}
		
	  def register = {
		   
		   // new user posts his registration details
		   if (request.method == 'POST') {
			   
			   // create domain object and assign parameters using data binding
			   def u = new User(params)
			   u.role="User"
			   if (params.password != params.confirm) {
				   flash.message = "Password mismatch."
				   redirect(uri: request.getHeader('referer') )
				   return
				}
			   User us=User.find{username==params.username}
			   if(us){
				   flash.message="Username already exists."
				   redirect(uri: request.getHeader('referer') )
				   return
			   }
			   int count=0
			   String str=params.name.toString()
			   for (int i = 0; i < str.length(); i++) {
				   
							   //If we find a non-digit character we return false.
							   if (!Character.isLetter(str.charAt(i))){
							   	if(!Character.isWhitespace(str.charAt(i))){
								   count=count+1;
							   	}
							   }
						   }
			   if(count>0){
				   flash.message="Name must contain letters only."
				   redirect(uri: request.getHeader('referer') )
				   return
			   }
			   
			   u.password=params.password.encodeAsPassword()
			   if (! u.save()) {
				   // validation failed, render registration page again
				   return [user:u]
			   } else {
				   // validate/save ok, store user in session, redirect to homepage
				   session.user = u
				   log.error "You have successfully registered."
				   u.errors.allErrors.each {log.error it.defaultMessage}
				   redirect(controller:"game", action: "index")
				  
				   
			   }
		   } else if (session.user) {
			   // don't allow registration while user is logged in
				   log.error "There was an error in registration process. Please try again later."
				   u.errors.allErrors.each {log.error it.defaultMessage}
		   		   redirect(controller:"game", action: "index")
		   }
	   }
	
	   def login = {
		   if (request.method == 'POST') {
			   User user = User.find{username==params.username}
			   if (!user) {
				  flash.message = "Username does not exist."
			   }
			   User us = User.find{
				   	username==params.username &&
					password== params.password.encodeAsPassword() 
			   }
			   //user = User.findByUsernameAndPasswordHashed(params.username, passwordHashed)
			   if (!us) {
				  flash.message = "Invalid input."
				  redirect(uri: request.getHeader('referer') )
				  return
			   }
			   
			   
			   session.user = user
			   redirect(uri: request.getHeader('referer') )
		   }
	   }
	
	   def admin={
		   
	   }
	   
	   def logout = {
		   session.invalidate()
		    redirect(uri: request.getHeader('referer') )
	   }
   }

