class AppDelegate
  attr_accessor :status_menu

  # The application did fucking finish fucking launching
  def applicationDidFinishLaunching(notification)
    @app_name = NSBundle.mainBundle.infoDictionary['CFBundleDisplayName']

    @status_menu = NSMenu.new

    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).init
    @status_item.setMenu(@status_menu)
    @status_item.setHighlightMode(true)
    @status_item.setTitle(@app_name)

    @status_menu.addItem createMenuItem("About #{@app_name}", 'orderFrontStandardAboutPanel:')
    @status_menu.addItem createMenuItem("Open Website", 'website')
    @status_menu.addItem createMenuItem("Refresh", 'refresh')
    @status_menu.addItem createMenuItem("Quit", 'terminate:')

    # Refresh the fucking thing
    refresh()
  end

  # Create the fucking menu item
  def createMenuItem(name, action)
    NSMenuItem.alloc.initWithTitle(name, action: action, keyEquivalent: '')
  end

  # Refresh the fucking sprint number
  def refresh
    Sprint.lookup() do |sprint|
      @status_item.setTitle("#{sprint.name} (#{sprint.jiraKey})")
    end
  end

  # Open the fucking website
  def website
    `open "http://whatfuckingsprintarewe.in"`
  end
end
