


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetTrackingAllJoined]
	@Site Varchar(10),
	@DateBegin DateTime = '3/1/2016'
AS
BEGIN

SET NOCOUNT ON;

SELECT    Top 300    DateAdd(HH, -3, TrackPageViews.DateStamp) As DateStamp, TrackSessionAndRemoteBrowser.TrackSession_Id, TrackPageViewMinBySession.TotalPages, 
                         TrackSessionAndRemoteBrowser.SessionId, TrackSessionAndRemoteBrowser.CookieId, TrackSessionAndRemoteBrowser.RemoteIp, 
                         TrackSessionAndRemoteBrowser.RemoteDomain, TrackSessionAndRemoteBrowser.UserLanguage, TrackSessionAndRemoteBrowser.BrowserInfo, 
                         TrackSessionAndRemoteBrowser.Site, TrackSessionAndRemoteBrowser.TrackBrowserId, TrackSessionAndRemoteBrowser.IsMobileDevice, 
                         TrackSessionAndRemoteBrowser.Cookies, TrackSessionAndRemoteBrowser.Crawler, TrackSessionAndRemoteBrowser.MobileDeviceManufacturer, 
                         TrackSessionAndRemoteBrowser.MobileDeviceModel, TrackSessionAndRemoteBrowser.Platform, TrackSessionAndRemoteBrowser.Type, TrackSessionAndRemoteBrowser.Frames, 
                         TrackSessionAndRemoteBrowser.Id, TrackSessionAndRemoteBrowser.Version, TrackPages.ScriptPath, TrackQueryString.QueryString, TrackReferer.Referer, dbo.GetDomain(TrackReferer.Referer) As RefererDomain
FROM            TrackPageViews LEFT OUTER JOIN
                         TrackPages ON TrackPageViews.TrackPage_Id = TrackPages.TrackPage_Id RIGHT OUTER JOIN
                         TrackQueryString RIGHT OUTER JOIN
                         TrackReferer RIGHT OUTER JOIN
                         TrackPageViewMinBySession ON TrackReferer.TrackPageView_Id = TrackPageViewMinBySession.TrackPageView_Id ON 
                         TrackQueryString.TrackPageView_Id = TrackPageViewMinBySession.TrackPageView_Id RIGHT OUTER JOIN
                         TrackSessionAndRemoteBrowser ON TrackPageViewMinBySession.TrackSession_Id = TrackSessionAndRemoteBrowser.TrackSession_Id ON 
                         TrackPageViews.TrackPageView_Id = TrackPageViewMinBySession.TrackPageView_Id
Where TrackSessionAndRemoteBrowser.Site=@Site
	And DateStamp > @DateBegin
Order by TrackSessionAndRemoteBrowser.TrackSession_Id Desc


END

