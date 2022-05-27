using System;

namespace sf.net.hsqlado.utils
{
	public class ArrayUtil
	{
		private ArrayUtil()
		{
		}

		public static Array ResizeArray(Array oldArray, int newSize)
		{
			int oldSize = oldArray.Length;

			Type elementType = oldArray.GetType().GetElementType();
			Array newArray = Array.CreateInstance(elementType, newSize);

			int preserveLength = Math.Min(oldSize, newSize);

			if (preserveLength > 0)
			{
				Array.Copy(oldArray, newArray, preserveLength);
			}

			return newArray;
		}
	}
}