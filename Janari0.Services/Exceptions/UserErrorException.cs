namespace Janari0.Services.Exceptions
{
    public class UserErrorException : Exception
    {
        public UserErrorException(string message)
            : base(message) { }
    }
}
