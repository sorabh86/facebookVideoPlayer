package com.math {
	
	public class MyXMLList {
		public static function sliceXMLList(xmllist:XMLList, startIndex : int, endIndex : int) : XMLList {
			return xmllist.(childIndex() >= startIndex && childIndex() <= endIndex);
		}
	}
}