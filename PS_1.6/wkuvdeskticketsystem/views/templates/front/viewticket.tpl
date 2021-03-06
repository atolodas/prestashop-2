{*
* 2010-2017 Webkul.
*
* NOTICE OF LICENSE
*
* All rights is reserved,
* Please go through this link for complete license : https://store.webkul.com/license.html
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade this module to newer
* versions in the future. If you wish to customize this module for your
* needs please refer to https://store.webkul.com/customisation-guidelines/ for more information.
*
*  @author    Webkul IN <support@webkul.com>
*  @copyright 2010-2017 Webkul IN
*  @license   https://store.webkul.com/license.html
*}

{capture name=path}
	<a {if $logged}href="{$link->getModuleLink('wkuvdeskticketsystem', 'customerticketlist')|escape:'html':'UTF-8'}"{/if}>
		{l s='Ticket List' mod='wkuvdeskticketsystem'}
	</a>
	<span class="navigation-pipe">{$navigationPipe|escape:'htmlall':'UTF-8'}</span>
	<span class="navigation_page">{l s='View Ticket' mod='wkuvdeskticketsystem'}</span>
{/capture}
{include file="$tpl_dir./errors.tpl"}

{if isset($smarty.get.success)}
	<p class="alert alert-success">
		<button data-dismiss="alert" class="close" type="button">×</button>
		{l s='Reply added successfully.' mod='wkuvdeskticketsystem'}
	</p>
{/if}
{if isset($smarty.get.success_col)}
	<p class="alert alert-success">
		<button data-dismiss="alert" class="close" type="button">×</button>
		{l s='Collaborator added successfully.' mod='wkuvdeskticketsystem'}
	</p>
{/if}
<div class="wk-module-block">
	<div class="wk-module-content">
		<div class="wk-module-page-title">
			<span>{l s='View Ticket' mod='wkuvdeskticketsystem'}</span>
		</div>
		<div class="wk-module-container">
			<div class="col-md-3">
				{*Manage collaborator*}
		        {include file="$self/../../views/templates/front/_partials/add-collaborator.tpl"}
				
				{*Display custom field if exist in ticket*}
				{include file="$self/../../views/templates/front/_partials/display-custom-fields.tpl"}
		    </div>
		    <div class="wk-left-border col-md-9">
		        <div id="ticket-detail">
			        <h4>
			            #{if isset($ticket->incrementId)}{$ticket->incrementId|escape:'htmlall':'UTF-8'}{/if} {if isset($ticket->subject)}{$ticket->subject|escape:'htmlall':'UTF-8'}{/if}
			        </h4>
		          	<div class="ticket-labels">
			            <span class="label label-default">{$ticket->formatedCreatedAt|escape:'htmlall':'UTF-8'}</span>
			            {if isset($ticket->status->id)}
			            	<span class="label label-default" title="Threads">{$ticketTotalThreads|escape:'htmlall':'UTF-8'} {l s='Replies' mod='wkuvdeskticketsystem'}</span>
			            {/if}
			            {if isset($ticket->type->id)}
			            	<span class="label label-default" title="Type">{$ticket->type->name|escape:'htmlall':'UTF-8'}</span>
			            {/if}
			            <span class="label label-default" title="Status">{$ticket->status->name|escape:'htmlall':'UTF-8'}</span>
		          	</div>
		        </div>
		        <div class="thread">
			        <div class="col-md-12 thread-created-info text-center">
			            <span class="info">
			            	{if isset($ticket->customer->detail->customer->id)}{$ticket->customer->detail->customer->name|escape:'htmlall':'UTF-8'}{/if} {l s='created a ticket' mod='wkuvdeskticketsystem'}
			            </span>
			            <span class="text-right date pull-right">
			            	{if isset($ticket->formatedCreatedAt)}{$ticket->formatedCreatedAt|escape:'htmlall':'UTF-8'}{/if}
			            </span>
			        </div>
			        <div class="col-md-12">
			        	<div class="">
				            <div class="pull-left">
				            	<span class="round-tabs">
				                	<img src="{if isset($ticket->customer->profileImage)}{$ticket->customer->profileImage|escape:'htmlall':'UTF-8'}{else}{$smarty.const._MODULE_DIR_}wkuvdeskticketsystem/views/img/wk-uvdesk-user.png{/if}">
				            	</span>
				            </div>
				            <div class="thread-info">
					            <div class="thread-info-row first">
					            	<span class="cust-name">{if isset($ticket->customer->detail->customer->id)}{$ticket->customer->detail->customer->name|escape:'htmlall':'UTF-8'}{/if}</span>
					            </div>
					            <div class="thread-info-row"></div>
				            </div>
			            	<div class="clearfix"></div>
						</div>
			            <div class="thread-body">
				            <div class="reply border-none">
				                <div class="main-reply">
				                	{if isset($ticket_reply)}{$ticket_reply}{/if}
				                </div>
				                {if isset($attachments) && $attachments}
				                	<div class="attachments first-attach">
					                	{foreach $attachments as $attachment}
					                    	<a href="{$link->getModuleLink('wkuvdeskticketsystem', 'viewticket', ['attach' => $attachment->id])|escape:'htmlall':'UTF-8'}">
					                			<i class="icon-download wk-attachment" data-attachment-id="{$attachment->id|escape:'htmlall':'UTF-8'}" title="{$attachment->name|escape:'htmlall':'UTF-8'}"></i>
					                		</a>
					                    {/foreach}
				                   	</div>
				                {/if}
				            </div>
			            </div>
			        </div>
		        </div>
		        <div class="text-center load-div">
		        	<button class="btn btn-primary" id="button-load"><i class="icon-spin icon-spinner"></i></button>
		        	<span class="loader-border"></span>
		        </div>
			    <div class="ticket-thread">{* ---- Load ticket threads here ---- *}</div>
			    <input type="hidden" name="threadPage" id="threadPage" value="0">
		        <div class="col-md-12" id="wk-ticket-reply-section">
		        	<div>
			        	<div class="pull-left">
				            <span class="round-tabs">
				            	<img src="{if isset($ticket->customer->profileImage) && $ticket->customer->profileImage}{$ticket->customer->profileImage|escape:'htmlall':'UTF-8'}{else}{$smarty.const._MODULE_DIR_}wkuvdeskticketsystem/views/img/wk-uvdesk-user.png{/if}">
				            </span>
			        	</div>
			        	<div class="thread-info">
			        		<span class="cust-name">{$ticket->customer->detail->customer->name|escape:'htmlall':'UTF-8'}</span>
			        	</div>
			        	<div class="clearfix"></div>
			        </div>
		        	<div class="thread-body">
			            <div class="thread-form">
			              	<form action="{$link->getModuleLink('wkuvdeskticketsystem', 'viewticket', ['id' => $incrementId])|escape:'htmlall':'UTF-8'}" method="post" enctype="multipart/form-data">
				                <input type="hidden" name="ticketId" value="{$ticketId|escape:'htmlall':'UTF-8'}">
				                <div class="reply border-none" style="padding: 0;">
				                	<textarea name="reply" id="reply" class="wk_tinymce form-control"></textarea>
					                <div class="form-group attachment-div">
							    		<div class="labelWidget">
							    			<i class="icon-trash remove-file" onclick="$(this).parent().remove();"></i>
											<label class="attach-file pointer"></label>
											{*In PS V1.6 uploader class automatically added but in PS V1.7, we need to add this class as a div *}
											<input type="file" name="attachment[]" class="fileUpload" style="display: none;" >
										</div>
										<span id="addFile">+ {l s='Attach File' mod='wkuvdeskticketsystem'}</span>
										<div class="clearfix"></div>
							    	</div>
					                <button type="submit" name="submitReply" class="btn btn-success">{l s='Reply' mod='wkuvdeskticketsystem'}</button>
					            </div>
			              	</form>
			            </div>
		          	</div>
		        </div>
		    </div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>
<div id="wk-loading-overlay">
	<i class="icon-spinner icon-spin"></i>
</div>

{strip}
	{addJsDef ticketId = $ticketId}
	{addJsDef uvdesk_ticket_controller = {$link->getModuleLink('wkuvdeskticketsystem', 'viewticket', ['id' => $incrementId])|escape:'htmlall':'UTF-8'}}
	{addJsDefL name='confirm_delete'}{l s='Are you sure want to delete?' mod='wkuvdeskticketsystem'}{/addJsDefL}
	{addJsDefL name='max_file'}{l s='Maximum Number of file is ' mod='wkuvdeskticketsystem'}{/addJsDefL}
	{addJsDefL name='invalid_file'}{l s='Invalid file type or size' mod='wkuvdeskticketsystem'}{/addJsDefL}
	{addJsDefL name='some_error'}{l s='Some error occured' mod='wkuvdeskticketsystem'}{/addJsDefL}
	{addJsDefL name='all_expended'}{l s='All Expanded' mod='wkuvdeskticketsystem'}{/addJsDefL}
	{addJsDefL name='show_more'}{l s='Show More' mod='wkuvdeskticketsystem'}{/addJsDefL}
	{addJsDefL name='replied'}{l s='replied' mod='wkuvdeskticketsystem'}{/addJsDefL}
{/strip}
