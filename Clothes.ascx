﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Clothes.ascx.cs"
    Inherits="Cowrie.Modules.Clothes.Clothes" %>
<%@ Import Namespace="Common" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<div class="filters">
    <h2>Filter by</h2>
    <asp:Panel ID="PanelCategories" runat="server" Visible="False">
        <h3>Category</h3>
        <div class="filter">
            <asp:CheckBoxList ID="CheckBoxListCategories" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxListCategories_SelectedIndexChanged" DataTextField="Name" DataValueField="Id">
            </asp:CheckBoxList>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelGenders" runat="server" Visible="False">
        <h3>Gender</h3>
        <div class="filter">
            <asp:CheckBoxList ID="CheckBoxListGenders" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxListGenders_SelectedIndexChanged">
                <asp:ListItem Value="1">Male</asp:ListItem>
                <asp:ListItem Value="2">Female</asp:ListItem>
            </asp:CheckBoxList>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelColours" runat="server" Visible="False">
        <h3>Colour</h3>
        <div class="filter">
            <asp:CheckBoxList ID="CheckBoxListColours" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxListColours_SelectedIndexChanged" DataTextField="Name" DataValueField="Id">
            </asp:CheckBoxList>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelBrands" runat="server" Visible="False">
        <h3>Brand</h3>
        <div class="filter">
            <asp:CheckBoxList ID="CheckBoxListBrands" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxListBrands_SelectedIndexChanged" DataTextField="Name" DataValueField="Id">
            </asp:CheckBoxList>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelStyles" runat="server" Visible="False">
        <h3>Style</h3>
        <div class="filter">
            <asp:CheckBoxList ID="CheckBoxListStyles" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxListStyles_SelectedIndexChanged" DataTextField="Name" DataValueField="Id">
            </asp:CheckBoxList>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelSizes" runat="server">
        <h3>Sizes</h3>
        <div class="filter">
            <asp:CheckBoxList ID="CheckBoxListSizes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CheckBoxListSizes_SelectedIndexChanged" DataTextField="Name" DataValueField="Id">
            </asp:CheckBoxList>
        </div>
    </asp:Panel>
</div>
<div class="products" style="width: 660px;">
    <h1>
        <asp:Label ID="LabelTitle" runat="server" Text="Clothes" /></h1>
    <div class="search">
        Search:
            <asp:TextBox ID="TextBoxSearch" runat="server" Width="100px"></asp:TextBox>
        &nbsp;<asp:Button ID="ButtonSubmit" runat="server" Text="Go" OnClick="ButtonSubmit_Click" ValidationGroup="ClothesSearch" />&nbsp;<asp:Button ID="ButtonClear" runat="server" Text="Clear" OnClick="ButtonClear_Click" CausesValidation="False" Visible="False" />
    </div>
    <h2>
        <asp:Label ID="LabelFilteredBy" runat="server" Visible="False" />
    </h2>
    <table style="width: 100%">
        <tr>
            <td>
                <asp:Label ID="LabelCount" runat="server" />
                items found
            </td>
            <td>Sort by
                <asp:DropDownList ID="DropDownListSortCriterias" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListSortCriterias_SelectedIndexChanged">
                    <asp:ListItem Selected="True">Position</asp:ListItem>
                    <asp:ListItem>Name: A to Z</asp:ListItem>
                    <asp:ListItem>Name: Z to A</asp:ListItem>
                    <asp:ListItem>Price: Low to High</asp:ListItem>
                    <asp:ListItem>Price: High to Low</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>View
                <asp:DropDownList ID="DropDownListPageSizes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListPageSizes_SelectedIndexChanged">
                    <asp:ListItem Selected="True">9</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>36</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:DataPager ID="DataPagerContent" runat="server" PagedControlID="ListViewContent" PageSize="9">
                    <Fields>
                        <asp:NextPreviousPagerField ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </td>
        </tr>
    </table>
    <asp:ListView ID="ListViewContent" runat="server" OnPagePropertiesChanging="ListViewContent_PagePropertiesChanging">
        <LayoutTemplate>
            <div style="width: 100%">
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
            </div>
        </LayoutTemplate>

        <ItemTemplate>
            <div style="margin: 5px; float: left; width: 210px; border-top-style: dotted; border-top-width: 1px; border-top-color: #C0C0C0; min-height: 280px">
                <table>
                    <tr>
                        <td style="vertical-align: middle" colspan="2">
                            <asp:HyperLink ID="HyperLinkName" runat="server" Text='<%# Eval("Name") %>' NavigateUrl='<%# DotNetNuke.Common.Globals.NavigateURL(DetailsTabId, "", "Id=" + Eval("Id")) %>' />
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle">
                            <%# Eval("UnitCost") != null ? String.Format("{0}{1:#0.00}", Utils.GetCurrencySymbol(Eval("CurrencyCode").ToString()), Eval("UnitCost")) : String.Empty %>
                        </td>
                        <td style="vertical-align: middle">
                            <telerik:RadRating ID="RadRatingStar" runat="server" Value='<%# Convert.ToDecimal(Eval("CustomerRating")) %>' ReadOnly="True" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:HyperLink ID="HyperLinkImage" runat="server" ImageUrl='<%# Eval("Image") %>' NavigateUrl='<%# DotNetNuke.Common.Globals.NavigateURL(DetailsTabId, "", "Id=" + Eval("Id")) %>' ImageWidth="100" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Literal ID="LiteralDescription" runat="server" Text='<%# Eval("Description") != null ? Server.HtmlDecode(Eval("Description").ToString().TruncateAtWord(120)) : String.Empty %>'></asp:Literal>
                        </td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:ListView>
</div>
