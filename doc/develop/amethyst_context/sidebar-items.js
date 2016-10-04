initSidebarItems({"mod":[["asset_manager","This module provides an asset manager which loads and provides access to assets, such as `Texture`s, `Mesh`es, and `Fragment`s."],["broadcaster","This module contains `Broadcaster` struct which allows publishing and polling specs entities. It is primarily used for event handling."],["event","This module contains the `EngineEvent` component and reexports glutin event types."],["input","The input handler for the game engine"],["renderer","This module provides a frontend for `amethyst_renderer`."],["timing","Utilities for working with time."],["video_context","This module contains `VideoContext` enum which holds all the resources related to video subsystem."]],"struct":[["Context","Contains all engine resources which must be shared by multiple parties, in particular `Renderer` and `Broadcaster`. An `Arc<Mutex<Context>>` is passed to every `Processor` run by the engine and a `&mut Context` is passed to every `State` method."],["ContextConfig","Contains configs for resources provided by `Context`"]]});