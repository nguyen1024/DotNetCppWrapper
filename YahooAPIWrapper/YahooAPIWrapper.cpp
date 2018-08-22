// This is the main DLL file.

#using "YahooAPI.dll"

#include <msclr\auto_gcroot.h>
#include "YahooAPIWrapper.h"

using namespace System::Runtime::InteropServices; // Marshal

class YahooAPIWrapperPrivate
{
    public: msclr::auto_gcroot<YahooAPI^> yahooAPI;
};

YahooAPIWrapper::YahooAPIWrapper()
{
    _private = new YahooAPIWrapperPrivate();
    _private->yahooAPI = gcnew YahooAPI();
}

double YahooAPIWrapper::GetBid(const char* symbol)
{
    return _private->yahooAPI->GetBid(gcnew System::String(symbol));
}

double YahooAPIWrapper::GetAsk(const char* symbol)
{
    return _private->yahooAPI->GetAsk(gcnew System::String(symbol));
}

const char* YahooAPIWrapper::GetCapitalization(const char* symbol)
{
    System::String^ managedCapi = _private->yahooAPI->GetCapitalization(gcnew System::String(symbol));

    return (const char*)Marshal::StringToHGlobalAnsi(managedCapi).ToPointer();
}

const char** YahooAPIWrapper::GetValues(const char* symbol, const char* fields)
{
    cli::array<System::String^>^ managedValues = _private->yahooAPI->GetValues(gcnew System::String(symbol), gcnew System::String(fields));

    const char** unmanagedValues = new const char*[managedValues->Length];

    for (int i = 0; i < managedValues->Length; ++i)
    {
        unmanagedValues[i] = (const char*)Marshal::StringToHGlobalAnsi(managedValues[i]).ToPointer();
    }

    return unmanagedValues;
}

YahooAPIWrapper::~YahooAPIWrapper()
{
    delete _private;
}