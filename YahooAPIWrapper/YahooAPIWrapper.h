// YahooAPIWrapper.h

#pragma once

class YahooAPIWrapperPrivate;

#ifdef BUILDINGYAHOOAPIWRAPPER
#define BYAEXPORT __declspec(dllexport)
#else
#define BYAEXPORT __declspec(dllimport)
#endif

class BYAEXPORT YahooAPIWrapper
{
    private: YahooAPIWrapperPrivate* _private;

    public: YahooAPIWrapper();

    public: ~YahooAPIWrapper();
    
    public: double GetBid(const char* symbol);

    public: double GetAsk(const char* symbol);

    public: const char* GetCapitalization(const char* symbol);
    
    public: const char** GetValues(const char* symbol, const char* fields);
};
