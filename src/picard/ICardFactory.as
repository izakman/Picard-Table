package picard
{
	import com.transmote.flar.marker.FLARMarker;

	public interface ICardFactory {
		
		 function createNewCard(marker:FLARMarker, cardID:Number):Card;
		
	}
}