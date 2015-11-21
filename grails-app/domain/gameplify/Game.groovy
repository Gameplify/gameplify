package gameplify

class Game {
	String gameTitle
	String gameLogo
	float gamePrice
	String gameDescription
	Date releaseDate
	float rating
	int numberOfRaters
	int numberOfReviews
	String toString(){
		"${gameTitle}"
	}
	static hasMany = [categories: GameCategory , screenshot: Screenshots , platform:Platform, reviews:Review]
	static belongsTo = [GameCategory , Platform]  
	 static constraints = {
    }
}
