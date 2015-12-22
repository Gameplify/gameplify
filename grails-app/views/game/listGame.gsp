
<!DOCTYPE html>
<html>
<head>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

  <!-- Site Properities -->
  <title>Game List</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'semantic.css')}">
 <link rel="stylesheet" type="text/css" href="${resource(dir:'dist', file:'semantic.css')}">
  <script src="${resource(dir:'dist/components', file:'semantic.min.js')}"></script>
 
</head>
<body>
<div class="ui fixed inverted menu">
      <g:include action="showNavbar"/>
 </div>
     
        <div class="ui two column stackable grid">
              <div class="row" style="margin-left: 0px;">
                      <div class="ui segment" style="height: auto">
                                  <div class="ui grid" style="width: 800px; padding: 20px; ">
                                      <h3 style="width: 770px;  margin-bottom: 0px;"> ${currentCategory } 
                                                  <div class="ui grid" style="margin-left: 610px; margin-top: -35px;">
                                                  			
                                                          
                                                        <g:each in="${platforms }" var="platform">
                                                        <g:link action="listGame" params="${[ platform:platform.platformName, categoryName: currentCategory] }">
                                                        <button class="ui icon button">
                                                            ${platform.platformName }
                                                          </button>
                                                          </g:link>	
                                                          </g:each>
                                                  </div>
                                       </h3>
                                  </div>
                               <g:if test="${gameCount > 0 }">
                                 <div class="ui segment"  style="width: 770px; height: auto;">
                                 
                                           <div class="ui cards" style="margin-bottom: 20px;margin-left: 50px;margin-right: 50px;margin-top: 20px;">
                                 	
                                 	<g:each in="${games}" status="i" var="game">
                                 	<g:link action="gameProfile" params="${[gameTitle: "${game.gameTitle}"]}">                             		

                                              <div class="ui segment" style=" height: 120px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top:0px;">
                                                                      <img class="ui tiny left floated image" src="${resource(dir: 'images', file: "${game.gameLogo}")}">
                                                                      <div class="ui 3 column stackable grid" style="margin-left: 62px;margin-bottom: 0px;margin-right: 0px; margin-top:0px;">
                                                                                <h5 style="    padding-left: 10px;margin-bottom: 0px;">${game.gameTitle }</h5>
                                                                                <div class="row" style="padding-bottom: 13px;padding-top: 5px;border-top-width: 5px;margin-top: 0px;margin-left: 3px;">
                                 									                  <g:each var="category" in="${game.categories}">
                                 									                  <a  style="margin-bottom: 5px;margin-left: 7px;"> ${category.categoryName }</a> 
                                                                                    
                                                                                      </g:each>
                                                                                </div>
                                                                      </div>
                                              </div> 
                                           </g:link>
                                           
                                   </g:each>

                                           </div>
                                   
									<div class="pagination" style="text-align: center;">
				<g:paginate action="listGame" total="${gameCount}" params="${[chosenPlatform:"${chosenPlatform}", categoryName: currentCategory]}" ></g:paginate>
							</div>
							 </div>
							  </div>
							</g:if>
						<g:else>
									 <div class="ui segment"  style="width: 770px; height: auto;">
									   <h5>No Results Found</h5>
									 </div> 
									 </div>
						</g:else>
                                  
                   
               
               <g:include controller="user" action="showUserAuthentication"/>
            </div>
       </div>
                    
</body>
</html>
